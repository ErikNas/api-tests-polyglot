import io.restassured.http.ContentType;
import org.json.JSONObject;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;

public class PetStoreTests {

    @Test
    void test() {
        String uri = "https://petstore.swagger.io/v2/pet/";
        String petName = "Барсик";

        JSONObject bodyJO = new JSONObject()
                .put("name", petName)
                .put("status", "available");

        String newPetId = given()
                .when()
                .contentType(ContentType.JSON)
                .body(bodyJO.toString())
                .post(uri)
                .then()
                .statusCode(200)
                .extract()
                .jsonPath()
                .getString("id");

        String actualPetName = given()
                .when()
                .contentType(ContentType.JSON)
                .get(uri + newPetId)
                .then()
                .statusCode(200)
                .extract()
                .jsonPath()
                .getString("name");

        Assertions.assertEquals(petName, actualPetName);
    }
}