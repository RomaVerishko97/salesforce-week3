public class BuyPageController {
    public Contact ct;
    public boolean showInfo { get; set; }
    public Product_Table__c pt { get; set; }
    public String detailMsg {get; set;}
    public String typeMsg {get; set;}
    public Integer count{get; set;}
    public Integer totalAmount{get; set;}
    
    public BuyPageController(){
        
        pt=new Product_Table__c();
        pt.Id=ApexPages.currentPage().getParameters().get('Id');
        pt = [SELECT Id, Name, Image_URL__c, Product_Description__c, Unit_Price__c, Units_Available__c 
              FROM Product_Table__c 
              WHERE Id =: pt.Id];
    }
    
    public Contact getContact(){
        if(ct == null) {
			ct = new Contact();
        }
        return ct;
    }   
    
    public void setAmount(){
        Integer amount = Integer.valueOf(ApexPages.currentPage().getParameters().get('amount'));
    totalAmount = amount;
    }
    
    public void deal(){
        
        if(count <= 0){
            detailMsg = 'Error';
            typeMsg = 'error';
            showInfo = true;
            return;
        }
        Savepoint sp = Database.setSavepoint();
        ct.id = null;
        upsert ct Contact.fields.Email;
        Order_Table__c no = new Order_Table__c(Product__c = pt.Id, Units__c = count, 
                                           Order_Amount__c = (pt.Unit_Price__c * count),
                                           Contact__c = ct.Id);
        insert no;
        
        Decimal availAmount = pt.Units_Available__c;
        availAmount = availAmount - count;
        
        if (availAmount < 0){
            Database.rollback(sp);
            detailMsg = 'You want more, then we have';
            typeMsg = 'error';
        }else {
            pt.Units_Available__c -= count;
            update pt;
            detailMsg = 'deal';
            typeMsg = 'info';
        }
        showInfo = true;
    }

    public PageReference Back(){
        
        PageReference back = new PageReference('/apex/TaskPage');
        
        return back;
    }

  }