use reqwest::blocking::Client;
use reqwest::{self, StatusCode, Response};
use serde::{Deserialize, Serialize};
use serde_json::{json, Value};

#[derive(Serialize, Deserialize)]
struct Pet {
    id: i64,
    name: String,
}

#[test]
fn test_create_new_pet() -> Result<(), reqwest::Error> {
    let uri = "https://petstore.swagger.io/v2/pet/";
    let pet_name = "Барсик";
    let body = json!({"name": pet_name, "status": "available"});

    let client = Client::new();

    let post_res = client.post(uri).json(&body).send()?;
    assert_eq!(post_res.status(), StatusCode::OK);

    let res_body = post_res.text()?;
    let root: Value = serde_json::from_str(&res_body).unwrap();

    let pet_id = root.get("id");
    let pet_uri = format!("{}{}", uri, pet_id.unwrap());
    // let pet_uri2 = uri2.push_str(pet_id.unwrap());

    let get_res = client.get(pet_uri).send()?;

    assert_eq!(get_res.status(), StatusCode::OK);

    let actual_pet: Pet = get_res.json()?;
    assert_eq!(actual_pet.name, pet_name);

    Ok(())
}
