// React Basics:
Frontend framework for building composable user interfaces. ()


Basic BoilerPlate:
/*

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>React Hello World</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react/16.1.1/umd/react.development.js" charset="utf-8"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/react-dom/16.1.1/umd/react-dom.development.js" charset="utf-8"></script>
</head>
<body>

<div id='root'>

</div>
    <script>
      function HelloWorld (props) {
        return React.createElement("p",{style: {color: "blue"}}, `Hello, ${props.name || "World"}!`)
      }

      ReactDOM.render(
        React.createElement(HelloWorld, {name: "Jon Snow"}),
        document.getElementById("root")
      )
    </script>
</body>
</html>

*/

Components: Basic Building Blocks of React.js 
    function ComponentName (props) {
        return React.createElement(...);
    }

JSX - Javascript Extended. Need a Middleware (Bable). 


react on rails gem: investigate it. 
create-react-app react-demo

Nesting Components: 

Dynamically Generate Components:
