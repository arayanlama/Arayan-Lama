const { test, expect } = require('@playwright/test');

const pages = [
  ['Home', '/'],
  ['Music', '/music.html'],
  ['Films', '/videos.html'],
  ['Blogs', '/blog.html'],
];

for (const [name, route] of pages) {
  test(`${name}: renders without horizontal overflow or JavaScript errors`, async ({ page }) => {
    const errors = [];
    page.on('pageerror', error => errors.push(error.message));
    await page.goto(route, { waitUntil: 'domcontentloaded' });
    await expect(page.locator('body')).toBeVisible();
    await expect(page.locator('h1').first()).toBeVisible();
    await page.evaluate(() => document.fonts.ready);
    const dimensions = await page.evaluate(() => ({
      documentWidth: document.documentElement.scrollWidth,
      viewportWidth: document.documentElement.clientWidth,
    }));
    expect(dimensions.documentWidth, 'horizontal overflow').toBeLessThanOrEqual(dimensions.viewportWidth + 2);
    expect(errors).toEqual([]);
    await page.screenshot({ path: `test-results/${name.toLowerCase()}-${test.info().project.name}.png`, fullPage: true, animations: 'disabled' });
  });
}

test('homepage navigation links reach all primary pages', async ({ page }) => {
  await page.goto('/');
  for (const target of ['music.html', 'videos.html', 'blog.html']) {
    const link = page.locator(`a[href="${target}"]`).first();
    await expect(link).toBeVisible();
    await expect(link).toHaveAttribute('href', target);
  }
});

test('homepage video carousel has an accessible play control', async ({ page }) => {
  await page.goto('/');
  const play = page.locator('.hero-reel-slide.is-active .hero-reel-poster');
  await expect(play).toBeVisible();
  await expect(play).toHaveAttribute('aria-label', /play/i);
});
