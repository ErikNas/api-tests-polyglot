require 'rspec'
require 'net/http'
require 'json'

describe "Pet store test" do
  it "create new pet" do
    uri = URI('https://petstore.swagger.io/v2/pet/')
    pet_name = 'Барсик'
    body = { name: pet_name, status: 'available' }
    headers = { 'Content-Type': 'application/json' }
    
    post_resp = Net::HTTP.post(uri, body.to_json, headers)
    expect(post_resp.code).to eq('200')

    uri.path += JSON.parse(post_resp.body)['id'].to_s

    get_resp = Net::HTTP.get_response(uri)
    expect(get_resp.code).to eq('200')
    expect(JSON.parse(get_resp.body)['name']).to eq(pet_name)
  end
end
