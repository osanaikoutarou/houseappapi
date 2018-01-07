/*
 *
 * LanguageProvider reducer
 *
 */

import { fromJS } from 'immutable';

import {
  REQUEST_LOGIN,
} from './constants';
import {
  DEFAULT_LOCALE,
} from '../App/constants'; // eslint-disable-line

const initialState = fromJS({
  locale: DEFAULT_LOCALE,
});

function loginReducer(state = initialState, action) {
  switch (action.type) {
    case REQUEST_LOGIN:
      return state
        .set('locale', action.locale);
    default:
      return state;
  }
}

export default loginReducer;
