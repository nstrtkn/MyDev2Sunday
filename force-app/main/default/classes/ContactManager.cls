@RestResource(urlMapping='/Contact/*')
global with sharing class ContactManager {

    @HttpGet
    global static Contact getCcontact(){
        RestRequest request =  RestContext.request;
        String uri = request.requestURI;
        String conId = uri.substringAfterLast('/');
        Contact c = [SELECT Id, FirstName, LastName, Title, Email, Department FROM Contact WHERE Id = :conId];
        return c;
    }

    @HttpPost
    global static Id postContact(String FirstName, String LastName, String Title, String Email, String Department){
        Contact con = new Contact();
        con.FirstName = FirstName;
        con.LastName = LastName;
        con.Title = Title;
        con.Email = Email;
        con.Department = Department;
        
        insert con;
        return con.id;
    }

    @HttpDelete
    global static String deleteCase(){
        RestRequest request = RestContext.request;
        String uri = request.requestURI;
        String conId = uri.substringAfterLast('/');
        Contact con = [SELECT Id FROM Contact where Id =:conId];
        delete con;
        return 'Contact deleted successfully';
    }

    @HttpPut
    global static Id putContact(String Id, String FirstName, String LastName, String Title, String Email, String Department){
        Contact con = new Contact();
        con.Id = Id;
        con.FirstName = FirstName;
        con.LastName = LastName;
        con.Title = Title;
        con.Email = Email;
        con.Department = Department;
        
        upsert con;
        return con.id;
    }

    @HttpPatch
    global static Contact patchContact() {
        RestRequest request = RestContext.request;
        String jsonString = request.requestBody.toString();
        
        Contact con = (Contact)JSON.deserialize(jsonString, Contact.class);
        update con;
        Contact conObj = [SELECT Id, FirstName, LastName, Title, Email, Department FROM Contact WHERE Id = :con.Id];
        return conObj;
    }
}
