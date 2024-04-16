// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SportsAcademy {
    struct Student {
        address studentAddress;
        string name;
        string contactNumber;
        bool enrolled;
    }
    
    struct Sport {
        uint256 nextAvailableSlot;
        mapping(uint256 => Student) students;
    }

    mapping(string => Sport) public sports;

    // function to enroll the students
    function setEnrollment(string memory _sport, address _studentAddress, string memory _name, string memory _contactNumber) public returns (string memory) {
        Sport storage currentSport = sports[_sport];
        uint256 availableSlot = currentSport.nextAvailableSlot;
        
        // Check if student is already enrolled in the course
        for (uint256 i = 0; i < availableSlot; i++) {
            if (currentSport.students[i].studentAddress == _studentAddress) {
                if (currentSport.students[i].enrolled == true) {
                    revert("Student already enrolled in the input sport");
                }
                else{
                    currentSport.students[i].name = _name;
                    currentSport.students[i].contactNumber = _contactNumber;
                    return "Success, Updated existing enrollment of student";
                }
            }
        }

        currentSport.students[availableSlot] = Student({
            studentAddress: _studentAddress,
            name: _name,
            contactNumber: _contactNumber,
            enrolled: true
        });
        currentSport.nextAvailableSlot++;
        return "Set operation completed successfully";
    }
    //function to remove enrollment
    function removeEnrollment(string memory _sport, address _studentAddress) public returns (string memory) {
    Sport storage currentSport = sports[_sport];
    
    for (uint256 i = 0; i < currentSport.nextAvailableSlot; i++) {
        if (currentSport.students[i].studentAddress == _studentAddress) {
            delete currentSport.students[i];
            return "Remove operation completed successfully";
        }
    }
    revert("Student not found in the input sport");
}

    // function to retrieve count of students enrolled for a specific sports
    function getSportTotalEnrollment(string memory _sport) public view returns (uint256) {
        uint256 count = 0;
        for (uint256 i = 0; i <= sports[_sport].nextAvailableSlot; i++) {
            if (sports[_sport].students[i].enrolled) {
                count++;
            }
        }
        return count;
    }
    // function to retrieve all students enrolled for a specific sports
    function getSportEnrollmentDetails(string memory _sport) public view returns (Student[] memory) {
        uint256 totalEnrollment = getSportTotalEnrollment(_sport);
        Student[] memory enrollmentDetails = new Student[](totalEnrollment);

        uint256 index = 0;
        for (uint256 i = 0; i <= sports[_sport].nextAvailableSlot; i++) {
            Student storage student = sports[_sport].students[i];
            if (student.enrolled) {
                enrollmentDetails[index] = student;
                index++;
            }
        }
        return enrollmentDetails;
    }
}
