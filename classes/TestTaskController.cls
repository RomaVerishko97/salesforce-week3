@isTest public class TestTaskController {
	@isTest static void taskPrefTest(){
        AddProductTest.addProduct(100);
        Product_Table__c prod = [SELECT Id FROM Product_Table__c LIMIT 1];
        PageReference taskPage = Page.TaskPage;
        taskPage.getParameters().put('id', prod.Id);
        String str = prod.Id;
        Test.setCurrentPage(taskPage);
        PageReference detailPage = Page.DetailPage;
        Test.startTest();
        
        TaskController taskController = new TaskController();
        System.assertEquals(detailPage.getUrl()+'?id='+str.toLowerCase(), taskController.pref().getUrl().toLowerCase());
        Test.stopTest();
    }
    @isTest static void taskBuyRefTest(){
        AddProductTest.addProduct(100);
        Product_Table__c prod = [SELECT Id FROM Product_Table__c LIMIT 1];
        PageReference taskPage = Page.TaskPage;
        taskPage.getParameters().put('id', prod.Id);
        String str = prod.Id;
        Test.setCurrentPage(taskPage);
        PageReference buyPage = Page.BuyPage;
        Test.startTest();
        
        TaskController taskController = new TaskController();
        System.assertEquals(buyPage.getUrl()+'?id='+str.toLowerCase(), taskController.buyref().getUrl().toLowerCase());
        Test.stopTest();
    }
    @isTest static void getProductsTest(){
        Product_Table__c pt = new Product_Table__c(Name = 'Test', Product_Description__c = 'qwertyuiqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
        insert pt;
        TaskController tc = new TaskController();
        tc.getProducts();
	System.assert(tc.getProducts() != null);
    }
}
