public class UpdateAccountHelper {
   
	//Your Zuora API Endpoint URL goes here.
    //DO NOT have a forward slash / at the end
	private static final String ZUORA_BASE_URL = '';				
    
    // Zuora authentication credentials
    private static final String CLIENT_ID = '';						//Your Zuora Client ID goes here
    private static final String CLIENT_SECRET = '';					//Your Zuora Client Secret ID goes here
    private static final String TRACK_ID = '';						//Your Zuora-Track-ID goes here
          
    @future(callout=true) 
    public static void sendUpdateJson(String json, String accountID){
        Http http = new Http();
        HttpRequest request = new HttpRequest(); 
        HTTPResponse response;
        String endpointURL = ZUORA_BASE_URL + '/v1/action/update';
        
        request.setEndpoint(endpointURL);
        request.setHeader('Authorization', 'Bearer ' + genOauthToken(accountID));
        
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json;charset=UTF-8');
        request.setBody(json);
        response = http.send(request);
        
        // Check if the update was successful
        if (response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
            System.debug('Updated successfully');
            
        } else {
            System.debug('Account update error: ' + response.getStatusCode() + ' ' + response.getBody());
            CreateErrorObject(response, request, accountID, endpointUrl);
        }
        
    }
    
   private static String genOauthToken(String zID){
		string token;
        HttpRequest request = new HttpRequest();
        HttpResponse response;
        request.setEndpoint(ZUORA_BASE_URL + '/oauth/token');
        request.setMethod('POST');
     
        
        Blob headerValue = Blob.valueOf(CLIENT_ID + ':' + CLIENT_SECRET);
        String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);
        
    
        
        request.setHeader('Zuora-Track-Id', TRACK_ID);
        request.setHeader('Accept', 'application/json');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Accept', 'application/json');
        request.setBody('grant_type=client_credentials');
        response = new Http().send(request);
        System.debug('Oauth attempt: ' + response.getBody());
        
        if(response.getStatusCode() == 200){
			String jsonString = response.getBody();
			Map<String, Object> jsonObject = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
            List<String> keys = new List<String>(jsonObject.keySet());
            String firstKey = keys[0];
            Object firstValue = jsonObject.get(firstKey);
            token = (String)firstValue; // assuming the first value is a string
            System.debug('Token successfully created: ' + token);
            return token;
        }else{
            System.debug('Token creation error: ' + response.getStatusCode() + ' ' + response.getBody());
            CreateErrorObject(response, request, zID, ZUORA_BASE_URL + '/oauth/token');
        }
        return '';
    }//end genOauthToken()
    
    private static void CreateErrorObject(HttpResponse response, HttpRequest request, String id, String endpointURL){
        ZuoraSyncError__c error = new ZuoraSyncError__c();
        error.APIEndpoint__c = endpointURL;
        error.ObjectID__c = id;
        error.ObjectType__c = 'Account';
        error.RequestBody__c = request.getBody();
        error.ResponseBody__c = response.getBody();
        error.ResponseCode__c = String.valueOf(response.getStatusCode());
        
        System.debug(error);
        insert error;
    }
    
    
    
}//end class