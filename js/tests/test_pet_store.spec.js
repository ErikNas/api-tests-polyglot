const { test, expect } = require("@playwright/test");
const JSONbig = require("json-bigint");

const URI = "https://petstore.swagger.io/v2/pet/";
const PET_NAME = "Барсик";

test("create new pet test", async ({ request }) => {
    const respPost = await request.post(URI, {
        data: {
            name: PET_NAME,
            status: "available",
        },
    });
    expect(respPost.ok()).toBeTruthy();

    const respJson = (await respPost.body()).toString();
    const id = JSONbig.parse(respJson).id;

    const respGet = await request.get(URI + id);
    expect(respGet.ok()).toBeTruthy();
    expect(await respGet.json()).toHaveProperty("name", PET_NAME);
});