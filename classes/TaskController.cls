public class TaskController {
    
private String sortOrder = 'Name';
    
public List<Product_Table__c> getProducts() {
    
    List<Product_Table__c> results = Database.query(
        'SELECT Id, Image_Url__c, Name, Product_Description__c, Unit_Price__c ' +
        'FROM Product_Table__c ' +
        'ORDER BY ' + sortOrder + ' ASC '
        );
	for(Product_Table__c pDescr : results) {
           if (pDescr.Product_Description__c.length() >=100) {
               pDescr.Product_Description__c = pDescr.Product_Description__c.abbreviate(100);
               
           }
       }
    
    
    return results;
    
}
    public Product_Table__c p {get; set;}
    public TaskController() {
        p = new Product_Table__c();
        p.Id=ApexPages.currentPage().getParameters().get('Id');
    }
    
    public PageReference pref(){
        PageReference ref = new PageReference('/apex/DetailPage?id='+p.Id);
        
        return ref;
    }
    public PageReference buyRef(){
        PageReference buyref = new PageReference('/apex/BuyPage?id='+p.Id);
        
        return buyref;
    }
}
