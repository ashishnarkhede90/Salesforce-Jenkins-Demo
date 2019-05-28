@isTest
public class AccountSearchControllerTest {
    
    @isTest
    static void testSearchAccounts() {
        List<Account> testAccounts = new List<Account>();
        for(Integer i=0; i<5; i++){
            Account acc = new Account();
            acc.Name = 'Test ' + i;
            testAccounts.add(acc);
        }
        insert testAccounts;

        Id [] fixedSearchResults= new Id[1];
		fixedSearchResults[0] = testAccounts[0].Id;
		Test.setFixedSearchResults(fixedSearchResults);
        
        Test.startTest();
            List<Account> accts = AccountSearchController.searchAccounts('Test');
            System.assertNotEquals(null, accts, 'Accounts should be present');
            System.assertEquals(true, accts.size()>0);
        Test.stopTest();
    }
}
