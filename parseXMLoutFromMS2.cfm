
<cfset OUTxmldoc = "E://WEB/HTI_Clients/Clients/0123/expanded/0123_2_072613_001/0123_2_072613_001_OUT.xml">
<cfset TransNum = " ">
<cfset TranStatus = " ">
<cfset TranReason = " ">
<cfset TranDate = " ">
<cfset TranTime = " ">


<cfoutput>

  	<!-- --------READ FILES---------- -->
		<cffile action="read" file="#OUTxmldoc#" variable="OutDocxml"> 
			
		<!-- --------TEST TO SEE IF FILE IS XML---------- -->
		<cfif isXML(OutDocxml) IS 'YES'>
			
			<!-- ---- PARSE XML -- -->
			<cfset documentdoc = XmlParse(OutDocxml)> 
					
			<cfset BatchNumber = documentdoc.File.Batch.xmlAttributes.BatchNumber>
			<cfset BatchStatus = documentdoc.File.Batch.BatchLevelFields.BatchStatus.xmlText>
			<cfset BatchReason = documentdoc.File.Batch.BatchLevelFields.BatchReason.xmlText>
					
				<cfloop array="#documentdoc.xmlRoot#" index="i" >	
				<cfloop array="#i.xmlchildren#" index="a">
				<cfloop array="#a.xmlchildren#" index="b">
					<cfif isDefined("b.xmlAttributes.TransNum")>
						<cfset TransNum = TransNum&b.xmlAttributes.TransNum&",">
						<cfset TranStatus = TranStatus&b.TranStatus.xmlText&",">
						<cfset TranReason = TranReason&b.TranReason.xmlText&",">
						<cfset TranDate = TranDate&b.TranDate.xmlText&",">
						<cfset TranTime = TranTime&b.TranTime.xmlText&",">
					</cfif>
				</cfloop>
				</cfloop>	
				</cfloop>	
		</cfif>
		<fieldset title="OUTXML" >
		<legend><b>OUTXML</b></legend>
		BatchNumber = #BatchNumber#
		<br>
		BatchStatus = #BatchStatus#
		<br>
		BatchReason = #BatchReason#
		<br>
		TransNum = #TransNum#
		<br>
		TranStatus = #TranStatus#
		<br>
		TranReason = #TranReason#
		<br>
		TranDate = #TranDate#
		<br>
		TranTime = #TranTime#
		<br>
		</fieldset>
		
														<!-- -------- WHAT TO DO IF REJECTED---------- -->
														
														
														<cfif BatchStatus CONTAINS "R">
														
														<cfset batchRejected = "#BatchNumber# has BatchStatus:#BatchStatus#">
														#batchRejected#<br>

														</cfif>
														
														<cfif TranStatus CONTAINS "A">
														
														#ListLen(TranStatus)#
														
														<cfset loopTimes = 0>
														
														<cfloop array="#listToArray(TranStatus)#" index="i" >
														<cfset loopTimes = loopTimes+1>
														
														#ListGetAt(TransNum, loopTimes)#<br>
														#ListGetAt(TranStatus, loopTimes)#<br>
														#ListGetAt(TranReason, loopTimes)#<br>
														#ListGetAt(TranDate, loopTimes)#<br>
														#ListGetAt(TranTime, loopTimes)#<br>
														
														</cfloop>

														</cfif>
		
</cfoutput>






























