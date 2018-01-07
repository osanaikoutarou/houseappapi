import React from 'react';
import { MuiThemeProvider, createMuiTheme } from 'material-ui/styles';
import {Button, Toolbar, IconButton, Input, Reboot, Grid, Paper } from 'material-ui';
import {Card, CardHeader, CardMedia, CardContent, CardActions} from 'material-ui';

const theme = createMuiTheme();

const styles = {
  root: {
    flexGrow: 1,
    padding: 50,
    textAlign: 'center',
  },
  card: {
    marginTop: 50,
    width: 500,
  },
};

export default class CreatePhotoPage extends React.PureComponent { // eslint-disable-line react/prefer-stateless-function

  constructor(props) {
    super(props);
  }

  render() {
    return (
      <div>
        <Reboot />
        <MuiThemeProvider theme={theme}>
          <div>
            Photo Create page
          </div>

        </MuiThemeProvider>
      </div>
    );
  }
}
