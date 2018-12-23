CSV Validator
================

* This is a service for validating CSV files that can be easily deployed through docker.
* You program the custom rules through the web UI.
* Rules can be combined in various ways to create a **rule-set**.
* When you are happy with your set of rules, call one of the validator's API endpoints to have it validate one of your CSV files.
  * The request will contain:
    * the **rule-set ID** to validate against
    * a url to where the CSV can be downloaded by the validator.
    * a url for the validator to **POST** a response to (webhook) stating if validation succeeded or failed and for what reason.
