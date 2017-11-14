1.) Youtube Search:
Downwards Dataflow.Only the most parent component should be responsible for fetching data. ()

// index.js 
import YTSearch from 'youtube-api-search';

YTSearch({ key: API_KEY, term: 'surfboards' }, function (data) {
    console.log(data)
})

2.)
import React, { Component }

class App extends Component {
        constructor(props) {
            super(props);

            this.state = { videos: [] }

            YTSearch({ key: API_KEY, term: 'surfboards' }, (videos) => {
                this.setState({ videos })
                // this.setSTate({ videos: videos})
            })
        }

        render() {
            return (
                <div>
                    <SearchBar />
                </div>
            )
        }
    }

3.) Props
// in video_list.js
import React from 'react'

const VideoList = (props) => {
    return (
        <ul className="col-md-4 list-group">
            {props.videos.length}
        </ul>
    );
};

export default VideoList

// in index.js
import React, { Component } from 'react';
import VideoList from './components/video_list';

render() {
    return (
        <div>
            <SearchBar />
            <VideoList videos={this.state.videos} />
        </div>
    )
}

4.) Building Lists with Map