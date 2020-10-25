import { getHours, getMinutes } from "https://deno.land/x/date_fns@v2.15.0/index.js";
const date = new Date();
console.log(`Welcome to Deno(${getHours(date)}:${getMinutes(date)}) 🦕`);

import { existsSync } from "https://deno.land/std@0.74.0/fs/exists.ts";
console.log(`Does /etc/passwd exist: ${existsSync("/etc/passwd")}`);
