/* @flow */

import * as React from 'react';
import { requireNativeComponent } from 'react-native';

type Props = {
  RootComponent: React.ComponentType<any>,
};

const Navigator = ({ RootComponent, ...props }: Props) => (
  <GLLNavigator {...props}>
    <RootComponent />
  </GLLNavigator>
);

const GLLNavigator = requireNativeComponent('GLLNavigator', null);

export default Navigator;
