// Подключение к базе данных Supabase.
// URL и ключ ниже — публичные, их можно спокойно хранить в коде сайта.

const SUPABASE_URL = "https://dvnyownkkpsuzxdwsubp.supabase.co";
const SUPABASE_KEY = "sb_publishable_Tzbzi3sSPvC7Xe-tAm_Ugg_TLeo-zH5";

const sb = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);
