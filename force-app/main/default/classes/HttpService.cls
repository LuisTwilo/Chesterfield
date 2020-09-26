public with sharing class HttpService {
    
    public static void postPostSalesInfoToAccess(String dataToSend, String endpoint){
        
        //Creating and setting the request attributes
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type','application/json');
        request.setBody(dataToSend);

        //Handling authorization
        String username = 'dbusr@chesterfieldfence.com';
        String password = 'Cfd_1968';

        Blob headerValue = Blob.valueOf(username+':'+password);
        String authorizationHeader = 'Basic '+EncodingUtil.base64Encode(headerValue);
        request.setHeader('Authorization', authorizationHeader);

        //Sending the request and waiting for a response
        if (Test.isRunningTest()) {
            
        } else {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() != 201) {
                System.debug('An error has ocurred: ' +
                    response.getStatusCode() + ' ' + response.getStatus());
            } else {
                System.debug(response.getBody());
            }
        }             
    }
}
