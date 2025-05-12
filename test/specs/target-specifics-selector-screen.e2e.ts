describe('Target Specifics Flow', () => {

    beforeEach(async () => {
    await driver.execute('mobile: terminateApp', { bundleId: 'marketing.app.com' });
    await driver.execute('mobile: launchApp', { bundleId: 'marketing.app.com' });
    });

    it('should display 15 items after loading', async () => {
        const loader = await $('~loadingIndicator');
        await loader.waitForDisplayed({ timeout: 1000 });

        const list = await $('~targetSpecificsItemsList');
        await list.waitForDisplayed({ timeout: 3000 });

        // Wait for loading spinner to disappear
        await loader.waitForDisplayed({ reverse: true, timeout: 3000 });

        const items = await $$('~targetSpecificsItem');
        expect(items.length).toBe(15);
    });

    it('should enable Next button after selecting items', async () => {
        const list = await $('~targetSpecificsItemsList');
        await list.waitForDisplayed({ timeout: 3000 });

        const items = await $$('~targetSpecificsItem');
        expect(items.length).toBeGreaterThan(1);

        const nextButton = await $('~nextButton');
        expect(await nextButton.isEnabled()).toBe(false);

        // Tap first item
        await items[0].click();

        // Wait and check button becomes enabled
        await nextButton.waitForEnabled({ timeout: 2000 });
        expect(await nextButton.isEnabled()).toBe(true);

        // Tap second item
        await items[1].click();
        expect(await nextButton.isEnabled()).toBe(true);
    });

    it('should disable Next button if selection is cleared', async () => {
        const list = await $('~targetSpecificsItemsList');
        await list.waitForDisplayed({ timeout: 3000 });

        const items = await $$('~targetSpecificsItem');
        expect(items.length).toBeGreaterThan(1);

        const nextButton = await $('~nextButton');
        expect(await nextButton.isEnabled()).toBe(false);

        // Tap first item
        await items[0].click();
        await nextButton.waitForEnabled({ timeout: 2000 });
        expect(await nextButton.isEnabled()).toBe(true);

        // Tap it again to deselect
        await items[0].click();

        // Wait a bit and check it's disabled
        expect(await nextButton.isEnabled()).toBe(false);
    });

});

