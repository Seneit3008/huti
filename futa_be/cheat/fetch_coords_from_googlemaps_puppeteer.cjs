// fetch_coords_from_googlemaps_click_first.cjs
// Chạy: node fetch_coords_from_googlemaps_click_first.cjs
// Input: stations_input.json
// Output: danhSachBenXe.full.json

const fs = require("fs");
const path = require("path");
const puppeteer = require("puppeteer");

const INPUT = path.join(__dirname, "stations_input.json");
const OUTPUT = path.join(__dirname, "danhSachBenXe.full.json");

// sleep
function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

// parse lat/lng từ URL
function extractLatLngFromURL(url) {
  const match = url.match(/@(-?\d+\.\d+),(-?\d+\.\d+)/);
  if (match) return { lat: parseFloat(match[1]), lng: parseFloat(match[2]) };
  return null;
}

// search và click kết quả đầu tiên
async function searchOne(page, name) {
  console.log(`Searching: ${name}`);
  const query = encodeURIComponent(name + " bến xe Việt Nam");
  const searchUrl = `https://www.google.com/maps/search/${query}`;

  await page.goto(searchUrl, { waitUntil: "networkidle2" });
  await sleep(2000);

  try {
    // chờ selector kết quả đầu tiên
    await page.waitForSelector("div[role='article']", { timeout: 5000 });
    await page.click("div[role='article']"); // click vào kết quả đầu tiên
    await sleep(2500); // chờ page chuyển URL
  } catch (err) {
    console.log("⚠ Không tìm thấy kết quả để click:", err.message);
  }

  const url = page.url();
  const coords = extractLatLngFromURL(url);

  if (!coords) {
    console.log(`❌ Không lấy được tọa độ cho: ${name}`);
    return null;
  }

  console.log(`   ✔ Found: ${coords.lat}, ${coords.lng}`);
  return coords;
}

// main
(async () => {
  if (!fs.existsSync(INPUT)) {
    console.error("⛔ Thiếu file stations_input.json");
    process.exit(1);
  }

  const stations = JSON.parse(fs.readFileSync(INPUT, "utf8"));
  const browser = await puppeteer.launch({
    headless: false,
    args: ["--no-sandbox", "--disable-setuid-sandbox"],
  });

  const page = await browser.newPage();
  page.setViewport({ width: 1300, height: 900 });

  const output = [];

  for (let i = 0; i < stations.length; i++) {
    const st = stations[i];
    console.log(`\n[${i + 1}/${stations.length}] === ${st.name} ===`);

    try {
      const coords = await searchOne(page, st.name);
      if (coords) {
        output.push({
          name: st.name,
          lat: coords.lat,
          lng: coords.lng,
          province_id: st.province_id,
        });
      } else {
        output.push({
          name: st.name,
          lat: null,
          lng: null,
          province_id: st.province_id,
        });
      }
    } catch (e) {
      console.log("⚠ Lỗi:", e.message);
      output.push({
        name: st.name,
        lat: null,
        lng: null,
        province_id: st.province_id,
      });
    }

    await sleep(1500); // tránh bị rate limit
    fs.writeFileSync(OUTPUT, JSON.stringify(output, null, 2));
  }

  console.log(`\n🎉 DONE! Xuất file: ${OUTPUT}`);
  await browser.close();
})();
