# Notion Meeting Note App

**Author**: Alan Jian

Lightweight note-taking app built to use Notion as a backend.

## Persistence

In order to persist and display our meeting notes, we run into two main problems:

1. `PKDrawing`s are only persistable as `.pkdrawing` files or as binaries via `.dataRepresentation()`
2. Notion only allows a [certain subset of files](https://developers.notion.com/reference/file-upload) to be uploaded
3. Notion also does not natively support the display of these drawings. We'd need to display these as PDFs.

To do this, within each Meeting Note entry in Notion, we have to store the following:

1. **PKDrawing representation (json)**: This is a hacked together representation that allows us to loselessly store the `PKDrawing` binary. More on this below.
2. **PDF representation**: This is a viewable version of our file that allows Notion to operate as both a storage and viewing layer for our notes.

### PKDrawing Representation

This needs its own section because oh my fucking god what a mess. To loselessly persist a PKDrawing, we must:

```
PKDrawing 
→ .dataRepresentation() → Data (Apple's binary format, lossless)
→ .base64EncodedString() → String (text encoding of binary, lossless)
→ wrap in JSON → {"drawing": "abc123..."}
→ upload as drawing.json to Notion
```

To invert this process and read from our store, we must:

```
download drawing.json from Notion
→ decode JSON → {"drawing": "abc123..."}
→ extract base64 string → "abc123..."
→ Data(base64Encoded:) → Data (back to original binary)
→ PKDrawing(data:) → PKDrawing (back to original drawing, lossless)
```

