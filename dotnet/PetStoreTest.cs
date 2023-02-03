using NUnit.Framework;
using RestSharp;
using System.Text.Json;

namespace NUnit.Tests;

public class Tests
{
    [Test]
    public void CreateNewPetTest()
    {
      var uri = "https://petstore.swagger.io/v2/pet/";
      var petName = "Барсик";

      var client = new RestClient();
      var postRequest = new RestRequest(uri)
        .AddHeader("Content-Type", "application/json")
        .AddJsonBody(new { name = petName, status = "available" });

      var postResponse = client.Post(postRequest);
      Assert.AreEqual(true, postResponse.IsSuccessful);
      Assert.AreEqual(200, (int)postResponse.StatusCode);
      
      TestContext.Progress.WriteLine(postResponse.Content);
      var id = JsonDocument.Parse(postResponse.Content).RootElement.GetProperty("id").ToString();
      TestContext.Progress.WriteLine(id);
      
      var getRequest = new RestRequest(uri+id);
      var getResponse = client.Get(getRequest);
      Assert.AreEqual(true, getResponse.IsSuccessful);
      Assert.AreEqual(200, (int)getResponse.StatusCode);
      var actualName = JsonDocument.Parse(getResponse.Content).RootElement.GetProperty("name").ToString();      
      Assert.AreEqual(petName, actualName);
    }
}
