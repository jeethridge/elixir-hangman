import { Socket } from "phoenix";

export default class HangmanSocket {

    constructor() {
        this.socket = new Socket("/socket", {})
        this.socket.connect()
        console.log("Connected to user socket.")
    }

}