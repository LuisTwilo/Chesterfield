
public with sharing class AccessCalloutQueueable implements Queueable, Database.AllowsCallouts{
    
    public String dataToSend;
    public String endpoint; 
    
    public AccessCalloutQueueable(String dataToSend, String endpoint) {
        this.dataToSend = dataToSend;
        this.endpoint = endpoint; 
    }

    public void execute(QueueableContext context){
    HttpService.postPostSalesInfoToAccess(dataToSend, endpoint);
    }
}
