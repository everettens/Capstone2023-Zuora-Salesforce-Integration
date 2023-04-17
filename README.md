# CofC Capstone Project

<div align="center">
  <a href="https://github.com/everettens/Capstone2023-Zuora-Salesforce-Integration">
    <img src="/Misc/header.jpg" alt="Logo" >
  </a>

  <h3 align="center">Zuora - Salesforce Integration</h3>

  <p align="center">
    College of Charleston
    <br />
    Computer Science Capstone 2023
    

<!--     <a href="/">Watch the video</a> -->
    
  </p>
</div>
  
  <!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#the-team">The Team</a></li>
      </ul>
    </li>
    <li>
      <a href="#approach">Approach</a>
      <ul>
        <li><a href="#design-assumptions">Design Assumptions</a></li>
        <li><a href="#prerequisites">Dependencies and Prerequisites</a></li>
      </ul>
    </li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>
</div>


<!-- ABOUT THE PROJECT -->
## About The Project
<p>
  This is a capstone project at the College of Charleston in partnership with world-class paymant management compnay Zuora. Our team was tasked to work with our client, Wes Spears, at Zuora on a project they chose. In order to mimic a real world, industry-style project, our team implemented the SCRUM framework. 
</p>
<p>
  The purpose of this project was to develop an API to sync account and contact information between Zuora and Salesforce. This will be able to save developers time and save the business money by being able to sync information efficiently and quickly.
</p>
<p>

</p>
  

### The Team

This project team was comprised of four College of Charleston students. Each team member served as Scrum Master for at least one sprint. 
* Henry Smith
* Sydney Camenzuli
* Nathan Everette
* West Harrell

Client and Zuora contact:  [Wes Spears (Zuora)](https://www.linkedin.com/in/wesleyspears/)
<br>
Professor: [Dr. Ellie Lovellette](https://www.linkedin.com/in/ellie-lovellette-7212a2ab/)




## Approach

<p>This solution is designed to automatically capture updates from a Salesforce Account or Contact sObject and apply those changes to the equivalent zObject in Zuora. The process flow will vary slightly depending on which type of sObject is updated.
</p>
<p>
	Once an Account or Contact is updated in Salesforce, a bespoke Apex trigger will fire on that sObject. The trigger will then take the updated information and build a map of strings and objects for each equivalent field between Salesforce and Zuora for that type of sObject (see below for a complete map of equivalent fields). It is worth noting that the UpdateContactTrigger builds an additional map of strings and objects to store mailing address information.
 </p>
 <p>
	Once the trigger has finished gathering and storing all the sObject’s information, it will check to see if the custom field ‘ZuoraID’ is empty. If this field is empty, then the process will end here, as there is no given Zuora ID for an equivalent zObject to be updated. If a Zuora ID is given, then the trigger will serialize the completed map of strings and objects into a JSON. The trigger will then pass this JSON, along with the Zuora ID, to a bespoke helper class, depending on the type of sObject that was updated.
 </p>
 <p>
	The helper class will then take the given JSON and make a Zuora REST API call to update the equivalent zObject, matched via the given Zuora ID from Salesforce.
The helper class also takes care of authentication and utilizes OAuth 2.0. This uses a separate method within the helper class to generate a token using the Client ID and Client Secret of the user’s Zuora sandbox’s OAuth 2.0 Provider.
 </p>

### Design Assumptions
* The user has access to both Salesforce and Zuora as well as their respective sandbox developemnt environments
* The sObject already has an equivalent zObject
* The user has a method of obtaining the Zuora ID for each Account and Contact sObject they wish to sync (i.e. using a Data Query)

### Prerequisites

* The triggers ‘UpdateAccountTrigger’ and ‘UpdateContactTrigger’ have been added to the Salesforce workspace
* The classes ‘UpdateAccountHelper’ and ‘UpdateContactHelper’ have been added to the Salesforce workspace
* Aforementioned classes and triggers have been configured correctly (more details below)
* The Salesforce Account and Contact sObjects have a custom field ‘zID’ for storing its Zuora ID
* The user’s Salesforce workspace has a custom ‘ZuoraSyncError’ sObject
* The user’s Zuora sandbox already has an OAuth 2.0 Provider set up
* The user has aforementioned OAuth 2.0 Provider’s Client ID and Client Secret





<!-- ACKNOWLEDGMENTS -->
## Acknowledgments


* [Wes Spears (Zuora)](https://www.linkedin.com/in/wesleyspears/)
* [Salesforce.com](https://developer.salesforce.com/docs)
* [@kevinohara's Trigger Frameworok](https://github.com/kevinohara80/sfdc-trigger-framework)


<p align="right">(<a href="#cofc-capstone-project">back to top</a>)</p>


