package tests

import (
	"encoding/json"
	"fmt"
	"testing"

	"github.com/go-resty/resty/v2"
	"github.com/stretchr/testify/assert"
)

type Pet struct {
	Id   int    `json:"id"`
	Name string `json:"Name"`
}

func TestCreateNewPet(t *testing.T) {
	uri := "https://petstore.swagger.io/v2/pet/"
	petName := "Барсик"
	body := `{"name": "` + petName + `", "status": "available"}`
	myPet := Pet{}

	client := resty.New()

	postResponse, _ := client.R().
		SetHeader("Content-Type", "application/json").
		SetBody(body).
		Post(uri)

	assert.Equal(t, 200, postResponse.StatusCode(), "Неверный статус код при создании зверушки")

	json.Unmarshal(postResponse.Body(), &myPet)

	getResponse, _ := client.R().
		Get(fmt.Sprintf("%s%d", uri, myPet.Id))

	json.Unmarshal(getResponse.Body(), &myPet)

	assert.Equal(t, 200, getResponse.StatusCode(), "Неверный статус код при получении зверушки")
	assert.Equal(t, petName, myPet.Name, "Неверное имя зверушки")
}
