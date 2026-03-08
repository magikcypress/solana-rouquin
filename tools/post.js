import { TwitterApi } from "twitter-api-v2";
import "dotenv/config";

const message = process.argv.slice(2).join(" ");
if (!message) {
  console.error("Usage: node post.js <message>");
  process.exit(1);
}

async function postTwitter(text) {
  const client = new TwitterApi({
    appKey: process.env.TWITTER_API_KEY,
    appSecret: process.env.TWITTER_API_SECRET,
    accessToken: process.env.TWITTER_ACCESS_TOKEN,
    accessSecret: process.env.TWITTER_ACCESS_SECRET,
  });
  const { data } = await client.v2.tweet(text);
  return `https://x.com/i/status/${data.id}`;
}

async function postTelegram(text) {
  const url = `https://api.telegram.org/bot${process.env.TELEGRAM_BOT_TOKEN}/sendMessage`;
  const res = await fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      chat_id: process.env.TELEGRAM_CHAT_ID,
      text,
      parse_mode: "HTML",
    }),
  });
  const json = await res.json();
  if (!json.ok) throw new Error(json.description);
  return json.result.message_id;
}

console.log(`\nPosting: "${message}"\n`);

const results = await Promise.allSettled([
  postTwitter(message),
  postTelegram(message),
]);

const [twitter, telegram] = results;

if (twitter.status === "fulfilled") {
  console.log(`Twitter  OK  ${twitter.value}`);
} else {
  console.error(`Twitter  FAIL  ${twitter.reason.message}`);
}

if (telegram.status === "fulfilled") {
  console.log(`Telegram OK  message #${telegram.value}`);
} else {
  console.error(`Telegram FAIL  ${telegram.reason.message}`);
}
