/** @type {import('next').NextConfig} */
const withPWA = require('next-pwa')({
  dest: 'public',
  register: true,
  skipWaiting: true,
  disable: process.env.NODE_ENV === 'development',
});

const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**.supabase.co',
      },
      {
        protocol: 'https',
        hostname: 'raw.githubusercontent.com',
      },
    ],
    formats: ['image/avif', 'image/webp'],
    deviceSizes: [320, 375, 390, 430, 640, 768, 1024, 1280],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
  },
  env: {
    NEXT_PUBLIC_APP_NAME: 'TCG情報局',
  },
};

module.exports = withPWA(nextConfig);
