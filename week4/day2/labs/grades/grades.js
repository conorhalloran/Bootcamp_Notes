const functions = {
  grading: function (score) {
    // let grade = parseInt(score);
      if (score >= 95) {
        return `Congratulations, you got an A+!!`;
      } else if (score >= 90) {
        return `Congratualtions, you got an A!`;
      } else if (score >= 80) {
        return `You did Alright... That's a B Grade`;
      } else if (score >= 70) {
        return `Not Bad, you got a C+`;
      } else if (score >= 60) {
        return `At least that you got a C`;
      } else if (score >= 50) {
        return `Well at least D is a pass`;
      } else {
        return `That's an F... study harder Fool`;
      }
    }
  };