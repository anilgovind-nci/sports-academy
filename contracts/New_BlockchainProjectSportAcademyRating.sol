// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract StudentRating {
    struct SportRating {
        uint256 overallRatingTotal;
        uint256 alreadyRatedStudentsCount;
    }
    
    mapping(string => SportRating) public sportRatings;
    // function for setting sport rating
    function setSportRating(string memory _sport, uint256 _rating) public {
        require(_rating >= 0 && _rating <= 5, "Rating must be between 0 and 5");
        SportRating storage rating = sportRatings[_sport];
        rating.overallRatingTotal += _rating;
        rating.alreadyRatedStudentsCount++;
    }
    // function for retrieving sport average.
    function getSportAverageRating(string memory _sport) public view returns (uint256) {
        SportRating storage rating = sportRatings[_sport];
        if (rating.alreadyRatedStudentsCount == 0) {
            return 0;
        } else {
            return rating.overallRatingTotal / rating.alreadyRatedStudentsCount;
        }
    }
}
