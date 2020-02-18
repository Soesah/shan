import { BaseService, Status, DataResponse } from '@/services/base.service';
import { Word } from '@/models/word.model';

interface Words {
  data: Word[];
}

class WordsService extends BaseService {
  private url: string = '/api/words';

  constructor() {
    super();
  }

  public async load(): Promise<DataResponse<Word[]>> {
    const response = await this.$http.get<Words>(`${this.url}`);

    const { status, data } = response;

    return {
      status: status === Status.Ok,
      data: status === Status.Ok ? data.data : [],
    };
  }
}

export default new WordsService();
