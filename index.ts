import { createDbWorker } from "sql.js-httpvfs";

const workerUrl = new URL(
  "sql.js-httpvfs/dist/sqlite.worker.js",
  import.meta.url
);
const wasmUrl = new URL("sql.js-httpvfs/dist/sql-wasm.wasm", import.meta.url);

async function load(db: string, query: string) {
  console.log("Querying " + db + ": " + query);
  const worker = await createDbWorker(
    [
      {
        from: "inline",
        config: {
          serverMode: "full",
          url: "/stiebel/" + db + ".db",
          requestChunkSize: 4096,
        },
      },
    ],
    workerUrl.toString(),
    wasmUrl.toString()
  );

  const result = await worker.db.query(query);
  return result;
}

(window as any).stiebel = (query: string) => load('stiebel', query);
(window as any).ouman = (query: string) => load('ouman', query);
(window as any).huawei = (query: string) => load('huawei', query);
(window as any).homewizard = (query: string) => load('homewizard', query);