public class DetailPageController {

    public Product_Table__c pt { get; set; }
    public DetailPageController(){
      pt=new Product_Table__c();
      pt.Id=ApexPages.currentPage().getParameters().get('Id');
    }
    public List<Product_Table__c> getProduct() {
        
        List<Product_Table__c> result = [SELECT Id, Image_Url__c, Name, Product_Description__c, Units_Available__c FROM Product_Table__c WHERE Id=: + pt.Id];
        
        return result;
    }
    public PageReference pref(){
        PageReference ref = new PageReference('/apex/TaskPage');
        
        return ref;
    }
    
}