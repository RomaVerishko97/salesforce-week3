@isTest
public class TestBuyPageController {
    @isTest static void getContactTest(){
        AddProductTest.addProduct(100);
        Product_Table__c prod = [SELECT Id FROM Product_Table__c LIMIT 1];
        PageReference buyPage = Page.BuyPage;
        buyPage.getParameters().put('id', prod.Id);
        Test.setCurrentPage(buyPage);
        Test.startTest();
        BuyPageController buyController = new BuyPageController();
        Contact ct = new Contact();
        System.assertEquals(true, buyController.getContact() == ct);
        ct.Email = 'qwer@sd.vg';
        buyController.getContact().Email = 'qwer@sd.vg';
        System.assertEquals(true, buyController.getContact() == ct);
        Test.stopTest();
    }
    @isTest static void setAmountTest(){
        AddProductTest.addProduct(100);
        Product_Table__c prod = [SELECT Id FROM Product_Table__c LIMIT 1];
        PageReference buyPage = Page.BuyPage;
        buyPage.getParameters().put('id', prod.Id);
        buyPage.getParameters().put('amount', '1000');
        Test.setCurrentPage(buyPage);
        Test.startTest();
        BuyPageController buyController = new BuyPageController();
        buyController.setAmount();
        System.assertEquals(1000, buyController.totalAmount);
        Test.StopTest();
    }
    @isTest static void backTest(){
        AddProductTest.addProduct(100);
        Product_Table__c prod = [SELECT Id FROM Product_Table__c LIMIT 1];
        PageReference buyPage = Page.BuyPage;
        buyPage.getParameters().put('id', prod.Id);
        Test.setCurrentPage(buyPage);
        PageReference taskPage = Page.TaskPage;
        Test.startTest();
        
        BuyPageController buyController = new BuyPageController();
        System.assertEquals(taskPage.getUrl(), buyController.back().getUrl().toLowerCase());
        Test.stopTest();
    }
    @isTest static void dealTest(){
        AddProductTest.addProduct(100);
        Product_Table__c prod = [SELECT Id FROM Product_Table__c LIMIT 1];
        PageReference buyPage = Page.BuyPage;
        buyPage.getParameters().put('id', prod.Id);
        Test.setCurrentPage(buyPage);
        BuyPageController buyController = new BuyPageController();
        buyController.getContact().LastName = 'qwerty';
        buyController.getContact().Email = 'qwerty@asd.zx';
        Test.startTest();
        
		buyController.count = 0;
		buyController.deal();
		List<Order_Table__c> ol = [SELECT Id FROM Order_Table__c];
		System.assertEquals(0, ol.size());  
        
        buyController.count = -1;
        buyController.deal();
        ol.clear();
        ol.addAll([SELECT Id FROM Order_Table__c]);
        System.assertEquals(0, ol.size());
        
        buyController.count = 2;
        buyController.deal();
        ol.clear();
        ol.addAll([SELECT Id FROM Order_Table__c]);
        System.assertEquals(0, ol.size());
        
        buyController.count = 5000;
        buyController.deal();
        ol.clear();
        ol.addAll([SELECT Id FROM Order_Table__c]);
        System.assertEquals(0, ol.size());
        System.debug(ol.size());
        Test.stopTest();
    }
}