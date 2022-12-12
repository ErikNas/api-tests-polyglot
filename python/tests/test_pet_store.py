import requests


def test_create_new_pet():

    uri = 'https://petstore.swagger.io/v2/pet/'
    pet_name = 'Барсик'

    body = {'name': pet_name, 'status': 'available'}

    post_response = requests.post(uri, json=body)
    assert post_response.status_code == 200, 'Неверный статус код при создании зверушки'

    get_response = requests.get(uri+str(post_response.json().get('id')))
    assert get_response.status_code == 200, 'Неверный статус код при получении зверушки'
    assert get_response.json().get('name') == pet_name
