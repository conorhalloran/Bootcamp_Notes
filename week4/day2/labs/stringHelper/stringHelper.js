const functions = {
    capitalize: function (string) {
        return `${string.charAt(0).toUpperCase() + string.slice(1)}`;
    },
    titleize: function (string) {
        return string.split(" ").map(function(word){
            return word.charAt(0).toUpperCase() + word.slice(1);
          }).join(" ");
    }
};

module.exports = functions;