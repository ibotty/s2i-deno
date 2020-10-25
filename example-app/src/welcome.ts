import { getHours, getMinutes } from "https://deno.land/x/date_fns@v2.15.0/index.js";
const date = new Date();
console.log(`Welcome to Deno(${getHours(date)}:${getMinutes(date)}) 🦕`);
