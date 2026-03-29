@mod @mod_scorm @javascript
Feature: Unstable network
  In order to avoid losing progress in a SCORM package
  As a learner
  I need to be notified if my network is unstable

  Background:
    Given the following "users" exist:
      | username | firstname  | lastname  | email                |
      | student1 | Student    | 1         | student1@example.com |
      And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
      And the following "course enrolments" exist:
      | user      | course | role    |
      | student1  | C1     | student |
      And the following "activities" exist:
      | activity | course | name       |
      | scorm    | C1     | Test SCORM |

  Scenario: The unstable network modal renders on the SCORM player page when network is unstable
    When I am on the "Test SCORM" "scorm activity" page logged in as "student1"
    And I press "Enter"
    And my network is unstable
    Then I should see "Due to an unstable internet connection"
    And I should see "Cancel" in the ".modal-footer" "css_element"

  Scenario: The unstable network modal can be closed without a redirect the first time it is shown
    When I am on the "Test SCORM" "scorm activity" page logged in as "student1"
    And I press "Enter"
    And my network is unstable
    And I click on "Cancel" "button" in the ".modal-footer" "css_element"
    Then I should not see "Due to an unstable internet connection"
    And I should not see "Enter" in the "#page-content" "css_element"

  Scenario: The unstable network modal cannot be closed without a redirect the second time it is shown
    When I am on the "Test SCORM" "scorm activity" page logged in as "student1"
    And I press "Enter"
    And my network is unstable
    And my network is unstable
    Then I should not see "Cancel" in the ".modal-footer" "css_element"
    And I click on "Exit activity" "button" in the ".modal-footer" "css_element"
    And I should see "Enter" in the "#page-content" "css_element"

  Scenario: Unstable network must be detected twice consecutively before a user must leave the SCORM activity
    When I am on the "Test SCORM" "scorm activity" page logged in as "student1"
    And I press "Enter"
    And my network is unstable
    And I click on "Cancel" "button" in the ".modal-footer" "css_element"
    And the session is touched
    And my network is unstable
    Then I should see "Cancel" in the ".modal-footer" "css_element"
    And my network is unstable
    And I should not see "Cancel" in the ".modal-footer" "css_element"