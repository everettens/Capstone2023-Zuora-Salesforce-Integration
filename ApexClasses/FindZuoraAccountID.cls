public class FindZuoraAccountID {
    public static void FindID(){
        
        //SELECT Id FROM Account WHERE (SELECT AccountName FROM Account WHERE AccountName = salesforceAccName)
        Http http = new Http();
        HttpRequest req = new HttpRequest(); 
        req.setEndpoint('https://capstone23-zuorasalesforc-a-dev-ed.develop.my.salesforce.com/_ui/common/apex/debug/ApexCSIAPI?action=KEEPALIVE&_=1677449742677');
        req.setMethod('GET');
        String username = 'capstoneapitest';
        String pw = 'zuoracapstone2023!';
        Blob headerValue = Blob.valueOf(username + ':' + pw);
        String authorizationHeader = 'Basic ' +
        EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        HTTPResponse response = http.send(req);
        
        req.setEndpoint('https://rest.apisandbox.zuora.com/v1/accounts');
        req.setMethod('GET');
        req.setHeader('Content-Type','application/json;charset=utf-8');
        response = http.send(req);
        System.Debug(response.getBody());
        
    }
		
    
    
    
}