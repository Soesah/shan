import axios, { AxiosStatic } from 'axios';

axios.interceptors.response.use(undefined, (err) => {
  if (err.response.status === 401) {
    document.location.href = '/login';
  }
});

export enum Status {
  Ok = 200,
}

export interface StatusResponse {
  status: boolean;
}

export interface MessageResponse extends StatusResponse {
  message: string;
}

export interface DataResponse<T> extends StatusResponse {
  data: T;
}

export interface MessageData {
  message: string;
}

export class BaseService {
  public $http: AxiosStatic;

  constructor() {
    // set up axios proxy to allow requests
    this.$http = axios;
  }
}
