public with sharing class RestCallouts {
    public static HttpResponse getCovidInfo(){
    
        //1. Prepare HttpRequest and wrap the necessary information in 
            HttpRequest request = new HttpRequest();
            request.setMethod('GET');
            request.setEndpoint('https://api.covidtracking.com/v1/us/current.json');
    
        //2. Prepare internet
            Http http = new Http();
    
        //3. Send the request over the internet to receive response
            HttpResponse response = http.send(request);
    
        //4. Process the response
    
           if(response.getStatusCode()==200){
             
             system.debug(response.getBody());
    
             string jsonstring = response.getBody();
    
             List<CovidInfoWrapper> wrappers = (List<CovidInfoWrapper>)JSON.deserialize(jsonString, List<CovidInfoWrapper>.class);
             
             CovidInfoWrapper wrapper = wrappers[0];
    
             list<Covid_Info__c> covidInfo = [SELECT id, name, negative__c, pending__c, positive__c, received_date__c 
                                        FROM  Covid_Info__c WHERE received_date__c = TODAY];
    
             if(!covidInfo.isEmpty()){
                covidInfo[0].Name = string.valueOf(wrapper.states);
                covidInfo[0].negative__c = wrapper.negative;
                covidInfo[0].positive__c = wrapper.positive;
                covidInfo[0].pending__c = wrapper.pending;
    
                update covidInfo;
    
    
             } else{
                Covid_Info__c newCovid = new Covid_Info__c();
                newCovid.Name = string.valueOf(wrapper.states);
                newCovid.negative__c = wrapper.negative;
                newCovid.positive__c = wrapper.positive;
                newCovid.pending__c = wrapper.pending;
                newCovid.received_date__c = date.today();
                insert newCovid;
             }                        
    
           }
           return response;
            
        }

        public static HttpResponse postPost() {

           ////1. Prepare HttpRequest and wrap the necessary information in
            HttpRequest request = new HttpRequest();
            request.setMethod('POST');
            request.setEndpoint('https://gorest.co.in/public/v2/posts');

            //1.1 Get the post records and prepare them into json string
            Posts__c post = [SELECT  name, title__c, body__c, user_id__c FROM posts__c WHERE createdDate = TODAY  LIMIT 1];

            PostWrapper posts = new PostWrapper();
            posts.user_id = integer.valueOf(post.user_id__c); 
            posts.title = post.title__c;
            posts.body = post.body__c;


            String jsonString = JSON.serialize(posts);
            System.debug(jsonString);
            request.setBody(jsonString);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            request.setHeader('Authorization', 'Bearer 5d46e969aee7a71a2f73f65bd762b328cccafcb56493e301fe6c5c027feebd18');

            ////2. Prepare internet
            Http http = new Http();

            ////3. Send the request over the internet to receive response
            HttpResponse response = http.send(request);
            System.debug(response);
            System.debug(response.getBody());

            ////4. Process the response
            if(response.getStatusCode() == 201) {
                System.debug('records have been created successfully!' + response.getBody());
            }
            else {
                System.debug('An error occured while creating the record.');
            }
            return response;
        }

}
   

