<?php

namespace Tests;

use Tests\Support\ApiTester;

class PetStoreCest
{

    public function createNewPet(ApiTester $I)
    {
        $URI = 'https://petstore.swagger.io/v2/pet/';
        $PET_NAME = 'Барсик';

        $I->sendPostAsJson($URI, [
            'name' => $PET_NAME,
            'status' => 'available'
        ]);
        $I->seeResponseCodeIs(200);
        $id = $I->grabDataFromResponseByJsonPath('$.id');

        $I->sendGet($URI . strval($id[0]));
        $I->seeResponseCodeIs(200);
        $I->seeResponseIsJson();
        $I->seeResponseContainsJson(array('name' => $PET_NAME));

    }
}
