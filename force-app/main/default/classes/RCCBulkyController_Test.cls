@isTest
public class RCCBulkyController_Test {

    
    @isTest static void testGetBulkyDateOptions() {
        
        
        Date d = Date.parse('12/12/2018');
        // create a case
        Bulky_Collection_Slot__c Bulkyslot = new Bulky_Collection_Slot__c(
          Name = '12th December 2018',  
    	  Collection_Date__c = d
        );
		insert Bulkyslot;
        
        
        List<Bulky_Collection_Slot__c> bulkyDates = RCCBulkyController.GetBulkyDateOptions();
        
        
        Account address = new Account(
            Name = 'test address'
        );
        insert address;
        
        Case caseObj = new Case(
          Description = 'Test Case',  
    	  Status = 'Working',
    	  Origin = 'Phone',
          Case_Tracking__c  = true,
          Case_Tracking_Email__c = 'andynuk@gmail.com', 
          Case_Tracking_Mobile__c = '07398 251287'
        );
		insert caseObj;
        
        
        Bulky_Collections__c bulky = new Bulky_Collections__c(
        Where_Items_Left__c = 'Front Garden', 
        Bulky_Item_1__c ='Bath',
        Bulky_Item_2__c ='Bath',
        Bulky_Item_3__c ='Bath',
        Bulky_Item_4__c ='Bath',
        Bulky_Items_Other__c ='Bath',
        Case__c = caseObj.Id,
        Bulky_Collection_Slot__c = Bulkyslot.Id
        );    
        insert bulky;
        
        List<Bulky_Collections__c> test1= RCCBulkyController.GetBulkyHistory(address.Id);
        
        List<Bulky_Collections__c> test2 = RCCBulkyController.GetBulkyReminder(bulky.Id);
        
        //RCCBulkyController.sendBulkyReminder(bulky.Id);
        
     }
}