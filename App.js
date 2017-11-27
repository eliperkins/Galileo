/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import * as React from 'react';
import { Button, Platform, StyleSheet, Text, View } from 'react-native';

import { Navigator } from './src';
import GalileoView from './src/View';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

const RootComponent = () => (
  <GalileoView
    style={styles.container}
    render={({ push }) => (
      <View style={styles.container}>
        <Button title="Push me" onPress={() => push(RootComponent)} />
      </View>
    )}
  />
);

export default () => (
  <Navigator RootComponent={RootComponent} style={{ flex: 1 }} />
);

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
