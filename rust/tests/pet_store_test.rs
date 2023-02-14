use serde::{Deserialize, Serialize};
use serde_json::{json, Value};

#[derive(Serialize, Deserialize)]
struct Pet {
    id: i64,
    name: String,
}

#[test]
fn test_create_new_pet() {
    let uri = "https://petstore.swagger.io/v2/pet/";
    let pet_name = "Барсик";
    let body = json!({"name": pet_name, "status": "available"});

    let client = reqwest::blocking::Client::new();
    
    let post_res = client.post(uri).json(&body).send().unwrap();

    let post_status_code = post_res.status();
    assert_eq!(post_status_code.as_u16(), 200);

    let res_body = post_res.text().unwrap();
    let root: Value = serde_json::from_str(res_body.as_str()).unwrap();

    let pet_id = root.get("id");
    let pet_uri = format!("{}{}", uri, pet_id.unwrap());

    let get_res = client.get(pet_uri).send().unwrap();

    let get_status_code = get_res.status();
    assert_eq!(get_status_code.as_u16(), 200);

    let actual_pet: Pet = get_res.json().unwrap();
    assert_eq!(actual_pet.name, pet_name);
}
