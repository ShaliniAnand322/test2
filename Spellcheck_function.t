[ ] 
[ ] 
[+] testcase Spellcheck_function ()
	[+] // Local Variables
		[ ] STRING sDoubleWdDesp, sDisplayedDelete2nd, sExpectedSpel
		[ ] sDoubleWdDesp = "The larger of the the gizmos"
		[ ] sExpectedSpel = "The larger of the gizmos"
		[ ] STRING sMemo = "We are the top supplier of Kraemer Gizmos."
		[ ] STRING sDesc,sEmail
	[+] //Update The Data File
		[ ] DataFileUpdate ("SpellCheck", "SpellCheckSmokeTest.qbw")
		[+] switch (eQBCountry)
			[+] case QB_US,QB_CA     //Added by Reshma - 28/02/2022
				[+] //Step1: Set Preference for Web Mail.
					[ ] QB.EditMenu.Preferences.Pick()
					[ ] Prefs.SelectItem ("Send Forms")
					[ ] MyPrefs ()
					[ ] Prefs.TypeKeys("<Alt-W>")
					[ ] Preferences.Add.Click()
				[+] //Step2. Add the Yahoo  ID as default settings
					[ ] Desktop.Typekeys("abc@yahoo.com")
					[ ] Desktop.Typekeys("<Tab>")
					[ ] Desktop.Typekeys("y")
					[ ] Desktop.Typekeys("<Enter>")
					[ ] Desktop.Find("//MainWin[@caption='Preferences']//Control[@caption='OK']").Click()
					[+] if(Warning.Exists())
						[ ] Warning.OK.Click()
	[+] // 1. Create Invoices for Customer job 'Customer 1'
		[ ] CreateInvoices.Invoke ()
		[ ] CreateInvoices.CustomerJob.Select("Customer1")  //Added by Reshma -28/02/2022
		[ ] CreateInvoices.Table1.Item.Select ("Item1", 1)	
		[+] if Warning.Exists ()
			[ ] Warning.OK.Click ()
	[+] // 2. Set the memo text for the Invoice.
		[ ] CreateInvoices.SetActive ()
		[+] if(ChangesToHMRCVATRegulation.Exists(2))
			[ ] ChangesToHMRCVATRegulation.OK.Click()
		[ ] CreateInvoices.Memo.SetText (sMemo)
		[ ] Retry:
		[ ] CreateInvoices.Ribbon.Email_Invoice.Select ()
		[ ] sleep(10)
		[+] if(InformationMissingOrInvalid.Exists())
			[ ] InformationMissingOrInvalid.CustomerEmail.SetText("TestIntuitMail@gmail.com")
			[ ] InformationMissingOrInvalid.Email.SetText("TestIntuitMail@gmail.com")
			[ ] InformationMissingOrInvalid.Ok.Click()
		[ ] 
		[+] if (MessageBox.Exists (5))
			[ ] MessageBox.No.Click ()
		[+] if (CheckSpellingOnForm.Add.Exists (5))
			[ ] CheckSpellingOnForm.Add.Click ()
		[ ] 
		[+] switch (eQBCountry)
			[+] case QB_UK
				[+] while (CheckSpellingOnForm.Add.Exists (5))
					[ ] CheckSpellingOnForm.Add.Click ()
		[ ] 
		[ ] //. In MU/Contention situation it is possible for the expected dialog not to come up due to locking. We must retry the action.
		[+] switch (eQBCountry)
			[+] case QB_US
				[+] if bContention
					[+] if !(SendInvoice.Exists ())
						[ ] goto Retry
	[+] //3. Change the text in Subject and Email Text.
		[+] switch (eQBCountry)
			[+] case QB_US
				[+] if(InformationMissingOrInvalid.Exists())
					[ ] InformationMissingOrInvalid.CustomerEmail.SetText("TestIntuitMail@gmail.com")
					[ ] InformationMissingOrInvalid.Email.SetText("TestIntuitMail@gmail.com")
					[ ] InformationMissingOrInvalid.Ok.Click()
					[ ] sleep(10)
				[ ] sleep(10)
				[+] if(MessageBox.Exists())
					[ ] MessageBox.No.Click()
				[ ] sleep(5)
				[ ] SendInvoice.SetActive ()
				[ ] Desktop.Find("//WPFUserControl[@caption='FROM']//WPFTextBox[@automationId='txtSub']").SetText(sMemo)
				[ ] sleep(3)
				[ ] Desktop.Find( "//WPFUserControl[@caption='FROM']//WPFTextBox[@automationId='txtBody']").SetText(sMemo)
				[ ] sleep(3)
		[ ] 
	[ ] 
	[+] //4. Click on Check Spelling Push Button.
		[+] switch (eQBCountry)
			[+] case QB_US
				[ ] Desktop.Find("//WPFUserControl[@caption='FROM']//WPFButton[@caption='Check Spelling']").Click ()
	[ ]  
	[+] //5.  Verify whether Spell check complete message appears
		[+] switch (eQBCountry)
			[+] case QB_US
				[+] if(CheckSpellingOnForm.Exists())
					[ ] sDesc=  "Spell check complete message appears, instead of Check Spelling on Form window appearing second time"
					[ ] VerifySafely (CheckSpellingOnForm.Exists(),TRUE ,sDesc)
					[ ] CheckSpellingOnForm.Close ()
				[+] if(QuickBooksInformation.Exists())
					[ ] QuickBooksInformation.OK.Click()
				[ ] 
	[+] //6. Close all opened windows.
		[+] switch (eQBCountry)
			[+] case QB_US
				[ ] SendInvoice.SetActive ()
				[ ] Desktop.Find("//WPFUserControl[@caption='FROM']//WPFButton[@automationId='btnCancel']").Click ()
			[+] case QB_UK
				[ ] SendInvoice.SetActive()
				[ ] SendInvoice.Cancel.Click()
				[ ] Desktop.Find("//WPFUserControl[@caption='FROM']//WPFButton[@automationId='btnCancel']").Click ()
			[+] case QB_CA
				[ ] SendInvoice.SetActive()
				[ ] SendInvoice.Cancel.Click()
		[ ] CreateInvoices.SetActive ()
		[ ] CreateInvoices.Close ()
	[ ] 
	[+] //7.  Invoke the item list and get a new item from the list
		[ ] Print ("Invoke the item list and get a new item from the list")
		[ ] ItemList.Invoke ()
		[ ] ItemList.SetActive ()
		[ ] ItemList.Item.New.Pick ()
		[+] if (AddEditMultipleListEntries.Exists (5))
			[ ] AddEditMultipleListEntries.SetActive ()
			[ ] AddEditMultipleListEntries.No.Click ()
	[ ] 
	[+] //8. Set the name and ItemNameNumber in the list
		[ ] Print ("Set the name and Item Name Number in the list")
		[ ] NewItem.SetActive ()
		[+] switch (eQBCountry)
			[+] case QB_US, QB_CA
				[ ] NewItem.Type.Select ("Inventory Part")
			[+] case QB_UK
				[ ] NewItem.Type.Select ("Stock Part")
		[ ] NewItem.ItemNameNumber.SetText ("Gizmo")
		[ ] NewItem.SetActive ()
	[ ] 
	[+] //9. To check the Spelling.
		[ ] Print ("Check for the spellings")
		[ ] NewItem.PurchaseDescription.TypeKeys (sDoubleWdDesp + "<Tab 4>")
		[ ] NewItem.Spelling.Click ()
	[ ] 
	[+] //10. Verify whether the spelling option exists and set it  to active.
		[ ] // Expected Result 2: Spell Check Option Exists.
		[ ] VerifySafely (CheckSpellingOnForm.Exists (5), TRUE, "spell check Option exists")
		[ ] CheckSpellingOnForm.SetActive ()
		[ ] CheckSpellingOnForm.Delete.Click()
		[ ] 
		[ ] // Description occurs twice
		[ ] VerifySafely (CheckSpellingOnForm.Exists (5), TRUE, "spell check Option exists")
		[ ] CheckSpellingOnForm.SetActive ()
		[ ] CheckSpellingOnForm.Delete.Click()
		[ ] 
		[ ] // Verifying 2nd 'the' in DescriptionOnSalesTransactions is deleted
		[ ] sDisplayedDelete2nd = NewItem.PurchaseDescription.GetText()
		[ ] VerifySafely (sDisplayedDelete2nd, sExpectedSpel, "2nd 'the' in DescriptionOnSalesTransactions is deleted")
		[+] if(QuickBooksDesktopInformation.Exists(3))
			[ ] QuickBooksDesktopInformation.OK.Click()
	[ ] 
	[+] // Clean Up
		[ ] NewItem.SetActive ()
		[ ] NewItem.Cancel.Click ()
		[ ] ItemList.SetActive ()
		[ ] ItemList.Close ()
		[ ] CloseCompany ()
	[ ] 
	[ ] 
	[ ] 
