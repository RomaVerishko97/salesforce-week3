@isTest
private class TestDetailPageController {
    @isTest static void detailTest(){
        AddProductTest.addProduct(100);
        Product_Table__c prod = [SELECT Id FROM Product_Table__c LIMIT 1];
        PageReference detailPage = Page.DetailPage;
        detailPage.getParameters().put('id', prod.Id);
        Test.setCurrentPage(detailPage);
        PageReference taskPage = Page.TaskPage;
        Test.startTest();
        
        DetailPageController detailController = new DetailPageController();
        System.assertEquals(taskPage.getUrl(), detailController.pref().getUrl().toLowerCase());
        Test.stopTest();
    }
    @isTest static void getProductsTest(){
        Product_Table__c pt = new Product_Table__c(Name = 'Test', Product_Description__c = 'qwertyui');
        insert pt;
        DetailPageController dpc = new DetailPageController();
        dpc.getProduct();
    }
}