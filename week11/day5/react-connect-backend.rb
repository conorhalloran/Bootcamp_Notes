rails new --api <app name>
create-react-native-app awesome_answers_rn
npm install -g exp
    How we view it on the computer: 
    exp start --ios --localhost
    exp start --ios --tunnel

1.) create-react-native-app awesome_answers_rn

2.) Test in App.js:
export default class App extends React.Component {

  async componentDidMount () {
    const response = await fetch('https://swapi.co/api/planets/1')
    const json = await response.json();
    console.log(json)
  }

  render() {

3.) mkdir components 
    mkdir libs
        touch requests.js
    3.1_ copy all from awesome_answers_react/src/lib/requests.js 
4.) App.js
    async componentDidMount () {
        /*
        fetch('https://swapi.co/api/planets/1')
        .then(res => res.json())
        */

        const res = await Question.getAll();
        console.log('--------------------')
        console.log(res)
        console.log('--------------------')
    }
5.) ngrok http 3000
6.) <FlatList>
    <SectionList>
=begin 
    _renderItem({ item }) {
        return (
            <View style={{
                marginTop: 5,
                marginBottom: 5,
                marginLeft: 10,
                marginRight: 10,
                backgroundColor: 'whitesmoke',
                padding: 3,
                borderRadius: 5
            }}>
                <Text style={{
                    fontSize: 20
                }}
                numberOfLines={2}
                >{item.title}</Text>
                <Text> By {item.user.first_name} {item.user.last_name}</Text>
            </View>
        )
    }

    render() {
        const { questions } = this.state;
        return (
            <FlatList
                data={questions}
                keyExtractor={item => item.id}
                renderItem={this._renderItem}
            />
        )
    }
}
=end
7.) yarn add react-navigation: https://reactnavigation.org/docs/intro/
    7.1) cd components QuestionStack.js
    import { StackNavigator } from 'react-navigation';
    import QuestionsIndexScreen from '../containers/QuestionsIndexScreen';

    const QuestionsStack = StackNavigator ({
        QuestionIndex: {screen: QuestionsIndexScreen}
    })
    7.2) app.js 
=begin
    import React from 'react';
    import { StyleSheet, Text, View } from 'react-native';
    import QuestionsStack from './components/QuestionsStack';

    export default class App extends React.Component {
    render() {
        return (
        <QuestionsStack />
        );
    }
    }
=end