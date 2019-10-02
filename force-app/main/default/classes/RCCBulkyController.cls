public class RCCBulkyController {

    @AuraEnabled
    public static List<Bulky_Collection_Slot__c> GetBulkyDateOptions() {
        /* This call returns all the future bulky collection dates
         * Bulky_Collection_Slot__c is custom table with date information
        */
        List<Bulky_Collection_Slot__c> bulkyDates;
        bulkyDates = [SELECT id, Name, Collection_Date__c,Number_of_Assisted_Visits__c,Number_of_Filled_Slots__c,Maximum_Normal_Collections__c,Maximum_Assisted_Collections__c FROM Bulky_Collection_Slot__c WHERE Collection_Date__c > TODAY ORDER BY Collection_Date__c ASC LIMIT 10];
        return bulkyDates;
    }
    
    @AuraEnabled
    public static List<Bulky_Collections__c> GetBulkyHistory(Id AddressId) {
        List<Bulky_Collections__c> bulkyDates;
        bulkyDates = [SELECT id, Name, Case__r.Account.Id, Case__r.CaseNumber, Bulky_Collection_Slot__r.Collection_Date__c FROM Bulky_Collections__c WHERE Case__r.Account.Id=: AddressId order by Bulky_Collection_Slot__r.Collection_Date__c DESC];
            
        return bulkyDates;
    }
    
    @AuraEnabled
    public static List<Bulky_Collections__c> GetBulkyReminder(Id BulkyId) {
        List<Bulky_Collections__c> bulkyInfo;
        bulkyInfo = [SELECT id, Name, Where_Items_Left__c, Bulky_Item_1__c,Bulky_Item_2__c,Bulky_Item_3__c,Bulky_Item_4__c,Bulky_Items_Other__c ,Internal_Waste_Team_Notes__c ,Case__r.CaseNumber, Case__r.Case_Tracking__c,Case__r.Case_Tracking_Email__c , Case__r.Case_Tracking_Mobile__c, Bulky_Collection_Slot__r.Name FROM Bulky_Collections__c WHERE Id=: BulkyId];
            
        return bulkyInfo;
    }
    
    
    @AuraEnabled
    public static void sendBulkyReminder(Id BulkyId) {
        List<Bulky_Collections__c> bulkyInfo = GetBulkyReminder(BulkyId);
        
        string message;
        
        if (bulkyInfo[0].Case__r.Case_Tracking__c)
           {

              // test for mobile
              if (bulkyInfo[0].Case__r.Case_Tracking_Mobile__c == null)
              {
              }
               else
              {
			       system.debug('Sending SMS');
                  message ='This is a reminder of your Bulky Collection on '+bulkyInfo[0].Bulky_Collection_Slot__r.Name+'.';
                  if (bulkyInfo[0].Where_Items_Left__c == 'Assisted')
                  {
                      message = message + 'You have an assisted Collection.';
                  }
                  else
                  {
                      message = message + 'Please put your items in the '+bulkyInfo[0].Where_Items_Left__c;
                  }                      
                  System.enqueueJob(new caseTrackingClass.sendSMSMessage(message, bulkyInfo[0].Case__r.Case_Tracking_Mobile__c));
              }
              if (bulkyInfo[0].Case__r.Case_Tracking_Email__c == null)
              {
              }
              else
              {
			       system.debug('Sending Email');
                  message ='<p>You have arranged a Bulky Collection on '+bulkyInfo[0].Bulky_Collection_Slot__r.Name+'.</p>';
                  message = message + '<p>We will collect the following items</p>';
                  if (bulkyInfo[0].Bulky_Item_1__c != null)
                  	 { message = message + '<p>'+bulkyInfo[0].Bulky_Item_1__c+'</p>';}
                  if (bulkyInfo[0].Bulky_Item_2__c != null)
                 	 { message = message + '<p>'+bulkyInfo[0].Bulky_Item_2__c+'</p>';}
                  if (bulkyInfo[0].Bulky_Item_3__c != null)
                 	 { message = message + '<p>'+bulkyInfo[0].Bulky_Item_3__c+'</p>';}
                  if (bulkyInfo[0].Bulky_Item_4__c != null)
                 	 { message = message + '<p>'+bulkyInfo[0].Bulky_Item_4__c+'</p>';}                  
                  if (bulkyInfo[0].Where_Items_Left__c == 'Assisted')
                  {
                      message = message + '<p>You have an assisted Collection and we will ensure that your items are safely collected from your property.';
                  }
                  else
                  {
                      message = message + '<p>Please put your items in the '+bulkyInfo[0].Where_Items_Left__c;
                  } 
                  message = message + '<p>If you would like to discuss this please call our customer service centre on 01572 722 577.</p>';
                  message = message + '<p>Please quote case reference '+bulkyInfo[0].Case__r.CaseNumber+'</p>';
                  
                  caseTrackingClass.sendEmailMessage('Rutland County Council - Bulky Collection Reminder',message, bulkyInfo[0].Case__r.Case_Tracking_Email__c);
              }
               
           }
       
       

    }}