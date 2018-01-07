import React from 'react';
import { MuiThemeProvider, createMuiTheme } from 'material-ui/styles';
import {Button, Toolbar, IconButton, TextField, FormControl, Input,InputLabel, Reboot, Grid, Paper } from 'material-ui';
import {Card, CardHeader, CardMedia, CardContent, CardActions} from 'material-ui';

const theme = createMuiTheme();

const styles = {
  root: {
    flexGrow: 1,
    padding: 50,
    width: '100%',
    height: '100%',
    textAlign: 'center',
  },
  card: {
    paddingTop: 50,
    paddingBottom: 50,
    textAlign: 'center',
  },
};

export default class LoginPage extends React.PureComponent { // eslint-disable-line react/prefer-stateless-function

  constructor(props) {
    super(props);
    this.state = {
      username: '',
      password: '',
    };
  }

  onLogin() {
    // TODO: Post login


  }

  render() {
    return (
      <div>
        <Reboot />
        <MuiThemeProvider theme={theme}>
          <div style={styles.root}>
            <h1>ケンチクカタチ＠admin</h1>
            <Card style={styles.card}>
              <CardContent>
                <FormControl>
                  <InputLabel htmlFor="email">Email</InputLabel>
                  <Input
                    id="email"
                    type="text"  />

                </FormControl>

                <br />

                <FormControl>
                  <InputLabel htmlFor="password">Password</InputLabel>
                  <Input
                    id="password"
                    type="password" />

                </FormControl>

                <br />
                <br />

                <FormControl>
                  <Button raised color="primary">Login</Button>
                </FormControl>

              </CardContent>

            </Card>
          </div>

        </MuiThemeProvider>
      </div>
    );
  }
}
