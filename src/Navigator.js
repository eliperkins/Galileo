/* @flow */

import * as React from 'react';

type Props = {
  RootComponent: React.ComponentType<any>,
};

const Navigator = ({ RootComponent }: Props) => <RootComponent />;

export default Navigator;
